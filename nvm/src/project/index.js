console.log("Running dummy project ...");

var waitLoop = function () {
  setTimeout(function () {
    waitLoop();
  }, 1000);
};

waitLoop();
