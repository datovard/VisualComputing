var giveClick = function (e) {
  document.getElementById("song").click();
}

document.body.addEventListener("click", giveClick, false);

var that = this;
document.getElementById("song").addEventListener('change', e => {
  e.stopPropagation();
  e.preventDefault();

  document.body.removeEventListener("click", giveClick, false);

  //get the file
  var file = e.target.files[0];
  var fileReader = new FileReader();

  fileReader.onload = function (e) {
      var fileResult = e.target.result;
      new DemoVR( fileResult );
  };

  fileReader.onerror = function (e) {
    debugger
  };

  fileReader.readAsArrayBuffer(file);
});
