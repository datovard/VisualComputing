'use strict';

$(document).ready(function () {
    var visualizer;
    visualizer = new SphereVisualizer();
});

class SphereVisualizer {
    constructor () {
      //constants
      this.numberOfSpheres = 8;
      this.radio = 30;
      this.sphereRadio = 3;
      this.reaction = 100;        // min 0 - max 254

      //Rendering
      this.scene;
      this.camera;
      this.renderer;
      this.controls;

      //spheres
      this.spheres = new Array();
      this.vertices = new Array();

      //colors
      this.indexArray;


      //audio
      this.javascriptNode;
      this.audioContext;
      this.sourceBuffer;
      this.analyser;

      this.initialize();
      this.createSpheres();
      this.setupAudioProcessing();
      this.handleDrop();
    }

    //initialize the visualizer elements
    initialize () {
      this.scene = new THREE.Scene();

      //get the width and height
      var WIDTH = window.innerWidth,
          HEIGHT = window.innerHeight;

      //get the renderer
      this.renderer = new THREE.WebGLRenderer({ antialias: true });
      this.renderer.setSize(WIDTH, HEIGHT);

      //append the rederer to the body
      document.body.appendChild( this.renderer.domElement );

      //create and add camera
      this.camera = new THREE.PerspectiveCamera(40, WIDTH / HEIGHT, 0.1, 20000);
      this.camera.position.set(0, 50, 100);
      this.scene.add( this.camera );

      var that = this;

      //update renderer size, aspect ratio and projection matrix on resize
      window.addEventListener('resize', function () {
          var WIDTH = window.innerWidth,
              HEIGHT = window.innerHeight;

          that.renderer.setSize(WIDTH, HEIGHT);

          that.camera.aspect = WIDTH / HEIGHT;
          that.camera.updateProjectionMatrix();
      });

      //background color of the scene
      this.renderer.setClearColor(0x000000, 1);

      // Floor
      var floorGeometry = new THREE.PlaneGeometry(1000, 1000, 20, 20);
      var floorMaterial = new THREE.MeshPhongMaterial({
        color: 0xecebec,
        specular: 0x000000,
        shininess: 100
      });

      var floor = new THREE.Mesh(floorGeometry, floorMaterial);
      floor.rotation.x = -0.5 * Math.PI;
      floor.receiveShadow = true;
      this.scene.add(floor);

      // Lights
      // Ambient light for general illumination
      var ambientLight = new THREE.AmbientLight(0x252525);
      this.scene.add(ambientLight);

      //Add interation capability to the scene
      this.controls = new THREE.OrbitControls(this.camera, this.renderer.domElement);

      this.indexArray = 0;
    }

    //create the spheres required to show the visualization
    createSpheres () {
      var y = 10;

      for( var i = 0; i < this.numberOfSpheres; i++ ){
          var geometry = new THREE.SphereGeometry( this.sphereRadio, 100, 100 );
          //var material = new THREE.MeshNormalMaterial({ wireframe: true });
          var material = new THREE.MeshPhongMaterial({
            // Required For Shadows
            color: 0xecebec,
            specular: 0x000000,
            shininess: 100
          });

          this.spheres[i] = new THREE.Mesh( geometry, material );

          this.spheres[i].position.set( Math.cos(2 * Math.PI/this.numberOfSpheres * i) * this.radio, y, Math.sin(2 * Math.PI/this.numberOfSpheres * i) * this.radio );

          this.vertices[i] = JSON.parse(JSON.stringify( this.spheres[i].geometry.vertices ));
          this.scene.add( this.spheres[i] );

          //create a light and add it to the scene
          // color, intensity, distance, angle, penumbra, decay
          var light = new THREE.PointLight(0xffffff, 0.8, 25, 0.4, 1, 10);
          //light.position.set( 0, 20, 0 );
          light.position.set( Math.cos(2 * Math.PI/this.numberOfSpheres * i) * this.radio, y+10, Math.sin(2 * Math.PI/this.numberOfSpheres * i) * this.radio );
          this.scene.add(light);
      }
    }

    setupAudioProcessing () {
        //get the audio context
        this.audioContext = new AudioContext();

        //create the javascript node
        this.javascriptNode = this.audioContext.createScriptProcessor(2048, 1, 1);
        this.javascriptNode.connect(this.audioContext.destination);

        //create the source buffer
        this.sourceBuffer = this.audioContext.createBufferSource();

        //create the analyser node
        this.analyser = this.audioContext.createAnalyser();
        this.analyser.smoothingTimeConstant = 0.3;
        this.analyser.fftSize = 512;

        //connect source to analyser
        this.sourceBuffer.connect(this.analyser);

        //analyser to speakers
        this.analyser.connect(this.javascriptNode);

        //connect source to analyser
        this.sourceBuffer.connect(this.audioContext.destination);

        var audioProcess = function () {
            // get the average for the first channel
            var array = new Uint8Array( this.analyser.frequencyBinCount );
            this.analyser.getByteFrequencyData(array);

            //render the scene and update controls
            this.renderer.render( this.scene, this.camera );
            this.controls.update();

            var step = Math.round( array.length / this.numberOfSpheres);

            this.indexArray = (this.indexArray + 1) % 360;

            for( var i = 0; i < this.numberOfSpheres; i++ ){
              var freqRatio = Math.floor( 255/this.numberOfSpheres );
              var freqsPerSphere = array.slice( i * freqRatio, (i+1)*freqRatio );
              var freqVertexRatio = Math.floor( this.vertices[i].length / freqRatio );

              this.spheres[i].geometry.dynamic = true;
              for( var j = 0; j < this.vertices[i].length; j++ ){
                this.spheres[i].geometry.vertices[j].x = this.vertices[i][j].x * (freqsPerSphere[ Math.floor(j/freqVertexRatio) ]/(255 - this.reaction) + 1);
                this.spheres[i].geometry.vertices[j].y = this.vertices[i][j].y * (freqsPerSphere[ Math.floor(j/freqVertexRatio) ]/(255 - this.reaction) + 1);
                this.spheres[i].geometry.vertices[j].z = this.vertices[i][j].z * (freqsPerSphere[ Math.floor(j/freqVertexRatio) ]/(255 - this.reaction) + 1);
              }
              this.spheres[i].geometry.verticesNeedUpdate = true;
              this.spheres[i].material.color.setHSL( this.indexArray/360, 1, 0.5 );
            }
        }.bind(this);

        //this is where we animates the spheres
        this.javascriptNode.onaudioprocess = audioProcess;
    }

    //start the audio processing
    start (buffer) {
        this.audioContext.decodeAudioData(buffer, decodeAudioDataSuccess, decodeAudioDataFailed);
        var that = this;

        function decodeAudioDataSuccess(decodedBuffer) {
            that.sourceBuffer.buffer = decodedBuffer
            that.sourceBuffer.start(0);
        }

        function decodeAudioDataFailed() {
            debugger
        }
    }

    handleDrop () {
        // does nothing
        var empty = function () {}.bind(this);

        // receives dragover events
        var toDragOver = function (e) {
          e.stopPropagation();
          e.preventDefault();
          e.dataTransfer.dropEffect = 'copy';
        }.bind(this);

        // receives drop files events
        var toDrop = function (e) {
          e.stopPropagation();

          e.preventDefault();

          //get the file
          var file = e.dataTransfer.files[0];
          var fileName = file.name;

          $("#guide").text("Playing " + fileName);

          var fileReader = new FileReader();
          var that = this;

          fileReader.onload = function (e) {
              var fileResult = e.target.result;
              that.start(fileResult);
          };

          fileReader.onerror = function (e) {
            debugger
          };

          fileReader.readAsArrayBuffer(file);
        }.bind(this);

        // event listeners
        document.body.addEventListener("dragenter", empty, false);
        document.body.addEventListener("dragover", toDragOver, false);
        document.body.addEventListener("dragleave", empty, false);
        document.body.addEventListener("drop", toDrop, false);
    }
};
