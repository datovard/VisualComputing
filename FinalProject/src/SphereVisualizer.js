var visualizer;

$(document).ready(function () {
    visualizer = new SphereVisualizer();
    visualizer.initialize();
    visualizer.createSpheres();
    visualizer.setupAudioProcessing();
    visualizer.handleDrop();
});


function SphereVisualizer() {
    //constants
    this.numberOfSpheres = 10;

    //Rendering
    this.scene;
    this.camera;
    this.renderer;
    this.controls;

    //spheres
    this.spheres = new Array();
    this.vertices = new Array();

    //audio
    this.javascriptNode;
    this.audioContext;
    this.sourceBuffer;
    this.analyser;
};

//initialize the visualizer elements
SphereVisualizer.prototype.initialize = function () {
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
};

//create the bars required to show the visualization
SphereVisualizer.prototype.createSpheres = function () {
  var x = -50, y = 10, z = 0;

  for( var i = 0; i < this.numberOfSpheres; i++ ){
    var geometry = new THREE.SphereGeometry(2, 100, 100 );//, 0, Math.PI * 2, 0, Math.PI * 2);
    var material = new THREE.MeshNormalMaterial({ wireframe: true });
    this.spheres[i] = new THREE.Mesh( geometry, material );

    this.spheres[i].position.set( x, y, x );
    x += 10;

    this.vertices[i] = JSON.parse(JSON.stringify( this.spheres[i].geometry.vertices ));
    this.scene.add( this.spheres[i] );

    //create a light and add it to the scene
    // color, intensity, distance, angle, penumbra, decay
    var light = new THREE.PointLight(0xffffff, 0.1, 23, 0.4, 1, 2);
    light.position.set( 0, 20, 0);
    this.scene.add(light);
  }
};

SphereVisualizer.prototype.setupAudioProcessing = function () {
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

    var that = this;

    //this is where we animates the bars
    this.javascriptNode.onaudioprocess = function () {

        // get the average for the first channel
        var array = new Uint8Array(that.analyser.frequencyBinCount);
        that.analyser.getByteFrequencyData(array);

        //render the scene and update controls
        visualizer.renderer.render(visualizer.scene, visualizer.camera);
        visualizer.controls.update();

        var step = Math.round( array.length / visualizer.numberOfSpheres);

        for( var i = 0; i < visualizer.numberOfSpheres; i++ ){
          var freqRatio = Math.floor( 255/visualizer.numberOfSpheres );
          var freqsPerSphere = array.slice( i * freqRatio, (i+1)*freqRatio );
          var freqVertexRatio = Math.floor(9902 / freqRatio );

          visualizer.spheres[i].geometry.dynamic = true;
          for( var j = 0; j < 9901; j++ ){
            visualizer.spheres[i].geometry.vertices[j].x = visualizer.vertices[i][j].x * (freqsPerSphere[ Math.floor(j/freqVertexRatio) ]/180 + 1);
            visualizer.spheres[i].geometry.vertices[j].y = visualizer.vertices[i][j].y * (freqsPerSphere[ Math.floor(j/freqVertexRatio) ]/180 + 1);
            visualizer.spheres[i].geometry.vertices[j].z = visualizer.vertices[i][j].z * (freqsPerSphere[ Math.floor(j/freqVertexRatio) ]/180 + 1);
          }
          visualizer.spheres[i].geometry.verticesNeedUpdate = true;
        }
    }
};

//start the audio processing
SphereVisualizer.prototype.start = function (buffer) {
    this.audioContext.decodeAudioData(buffer, decodeAudioDataSuccess, decodeAudioDataFailed);
    var that = this;

    function decodeAudioDataSuccess(decodedBuffer) {
        that.sourceBuffer.buffer = decodedBuffer
        that.sourceBuffer.start(0);
    }

    function decodeAudioDataFailed() {
        debugger
    }
};

//util method to get random colors to make stuff interesting
SphereVisualizer.prototype.getRandomColor = function () {
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
};

SphereVisualizer.prototype.handleDrop = function () {
    //drag Enter
    document.body.addEventListener("dragenter", function () {

    }, false);

    //drag over
    document.body.addEventListener("dragover", function (e) {
        e.stopPropagation();
        e.preventDefault();
        e.dataTransfer.dropEffect = 'copy';
    }, false);

    //drag leave
    document.body.addEventListener("dragleave", function () {

    }, false);

    //drop
    document.body.addEventListener("drop", function (e) {
        e.stopPropagation();

        e.preventDefault();

        //get the file
        var file = e.dataTransfer.files[0];
        var fileName = file.name;

        $("#guide").text("Playing " + fileName);

        var fileReader = new FileReader();

        fileReader.onload = function (e) {
            var fileResult = e.target.result;
            visualizer.start(fileResult);
        };

        fileReader.onerror = function (e) {
          debugger
        };

        fileReader.readAsArrayBuffer(file);
    }, false);
}
