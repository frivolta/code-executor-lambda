const { exec } = require("child_process");

exports.handler = async (event) => {
  return new Promise((resolve, reject) => {
    exec("npm run hello", (error, stdout, stderr) => {
      if (error) {
        console.error(`exec error: ${error}`);
        reject(`Error: ${error.message}`);
        return;
      }
      if (stderr) {
        console.error(`stderr: ${stderr}`);
        reject(`Stderr: ${stderr}`);
        return;
      }
      console.log(`stdout: ${stdout}`);
      resolve(`Success: ${stdout}`);
    });
  });
};
