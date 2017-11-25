'use strict';

/*$(document).ready(function () {
    var visualizer;
    visualizer = new SphereVisualizer();
});*/

/*!
 *
 * Copyright 2016 Google Inc. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

'use strict';

/* eslint-env es6 */

class SphereVisualizer {

  static get CAMERA_SETTINGS () {
    return {
      viewAngle: 45,
      near: 0.1,
      far: 10000
    };
  }

  constructor ( file ) {
    // constants
    this.numberOfSpheres = 8;
    this.radio = 7;
    this.sphereRadio = 1;
    this.reaction = 100;

    this._width;
    this._height;
    this._renderer;
    this._camera;
    this._aspect;
    this._settings;
    this._box;
    this._container = document.querySelector('#container');

    //Spheres
    this.spheres = new Array();
    this.vertices = new Array();

    //colors
    this.indexArray = 0;

    this.clearContainer();
    this.createRenderer();

    this._onResize = this._onResize.bind(this);
    this._update = this._update.bind(this);
    this._onResize();

    this.createCamera();
    this.createScene();
    this.createMeshes();

    // 1-time calculations
    this.freqRatio = Math.floor( 255/this.numberOfSpheres );
    this.verticesLength = this.vertices[0].length;
    this.freqVertexRatio = Math.floor( this.verticesLength / this.freqRatio );
    this.reactionRatio = 255 - this.reaction;

    this._addEventListeners();
    this.setupAudioProcessing();
    this.start(file);

    requestAnimationFrame(this._update);
  }

  _update () {
    this.indexArray = ( this.indexArray + 1 ) % 360;
    if ( this.freqs != null && this.freqs != undefined ){
      var freqsPerSphere, quantity;
      for( var i = 0; i < this.numberOfSpheres; i++ ){
        freqsPerSphere = this.freqs.slice( i * this.freqRatio, (i+1)*this.freqRatio );
        for( var j = 0; j < this.vertices[i].length-3; j+= 3  ){
          quantity = (freqsPerSphere[ Math.floor(j/this.freqVertexRatio) ]/this.reactionRatio) + 1;
          this.spheres[i].geometry.vertices[j].x = this.vertices[i][j].x * quantity;
          this.spheres[i].geometry.vertices[j].y = this.vertices[i][j].y * quantity;
          this.spheres[i].geometry.vertices[j].z = this.vertices[i][j].z * quantity;

          this.spheres[i].geometry.vertices[j+1].x = this.vertices[i][j+1].x * quantity;
          this.spheres[i].geometry.vertices[j+1].y = this.vertices[i][j+1].y * quantity;
          this.spheres[i].geometry.vertices[j+1].z = this.vertices[i][j+1].z * quantity;

          this.spheres[i].geometry.vertices[j+2].x = this.vertices[i][j+2].x * quantity;
          this.spheres[i].geometry.vertices[j+2].y = this.vertices[i][j+2].y * quantity;
          this.spheres[i].geometry.vertices[j+2].z = this.vertices[i][j+2].z * quantity;
        }
        this.spheres[i].geometry.verticesNeedUpdate = true;
        this.spheres[i].material.color.setHSL( this.indexArray/360, 1, 0.5 );
      }
    }

    this._render();
  }

  _render () {
    this._renderer.render(this._scene, this._camera);
    requestAnimationFrame(this._update);
  }

  _onResize () {
    this._width = window.innerWidth;
    this._height = window.innerHeight;
    this._aspect = this._width / this._height;

    this._renderer.setSize(this._width, this._height);

    if (!this._camera) {
      return;
    }

    this._camera.aspect = this._aspect;
    this._camera.updateProjectionMatrix();
  }

  _addEventListeners () {
    window.addEventListener('resize', this._onResize);
  }

  clearContainer () {
    this._container.innerHTML = '';
  }

  createRenderer () {
    this._renderer = new THREE.WebGLRenderer();
    this._container.appendChild(this._renderer.domElement);
  }

  createCamera () {
    this._settings = SphereVisualizer.CAMERA_SETTINGS;
    this._camera = new THREE.PerspectiveCamera(
        this._settings.viewAngle,
        this._aspect,
        this._settings.near,
        this._settings.far
    );
    this._camera.position.set(0, -1, 0);
  }

  createScene () {
    this._scene = new THREE.Scene();
  }

  createMeshes () {
    //create a light and add it to the scene
    // color, intensity, distance, angle, penumbra, decay
    var light = new THREE.PointLight(0xffffff, 0.8, 25, 0.4, 1, 10);
    light.position.set( 0,5,0 );
    this._scene.add(light);

    var y = 0;
    for( var i = 0; i < this.numberOfSpheres; i++ ){
        var geometry = new THREE.SphereGeometry( this.sphereRadio, 100, 100 );
        //var material = new THREE.MeshNormalMaterial();

        var material = new THREE.MeshPhongMaterial({
          // Required For Shadows
          color: 0xecebec,
          specular: 0x000000,
          shininess: 100
        });

        this.spheres[i] = new THREE.Mesh( geometry, material );
        this.spheres[i].position.set( Math.cos(2 * Math.PI/this.numberOfSpheres * i) * this.radio, y, Math.sin(2 * Math.PI/this.numberOfSpheres * i) * this.radio );
        this.vertices[i] = JSON.parse(JSON.stringify( this.spheres[i].geometry.vertices ));
        this._scene.add( this.spheres[i] );
    }

    // Room.
    const roomGeometry = new THREE.BoxGeometry(20, 3, 20, 10, 2, 10);
    const roomMaterial = new THREE.MeshBasicMaterial({
      wireframe: true,
      opacity: 0.1,
      transparent: true,
      side: THREE.BackSide
    });
    const room = new THREE.Mesh(roomGeometry, roomMaterial);

    //room.position.z = -5;
    this._scene.add(room);
  }

  _onAudioProcess () {
    // get the average for the first channel
    this.freqs = new Uint8Array( this.analyser.frequencyBinCount );
    this.analyser.getByteFrequencyData( this.freqs );
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
      this._onAudioProcess = this._onAudioProcess.bind(this);

      //this is where we animates the spheres
      this.javascriptNode.onaudioprocess = this._onAudioProcess;
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
}
