const fs = require('fs');
const path = require('path');


const isPC = process.env.npm_lifecycle_event.includes('-pc');
module.exports = function () {
    if (!isPC) {
        const cssFiles = fs.readdirSync('./www/resource/css');
        cssFiles.forEach((cssFile) => {
          if (cssFile.indexOf('.') === 0) return;
          let fileContent = fs.readFileSync(path.resolve('./www/resource/css', cssFile), 'utf8');
          fileContent = fileContent
            .replace(/url\(resource\//gi, 'url(../')
            .replace(/url\(\/resource\//gi, 'url(../');
            fs.writeFileSync(path.resolve('./www/resource/css', cssFile), fileContent);
        });
    }
    else {
        const cssFiles = fs.readdirSync('./www/static/css');
        cssFiles.forEach((cssFile) => {
            if (cssFile.indexOf('.') === 0) return;
            let fileContent = fs.readFileSync(path.resolve('./www/static/css', cssFile), 'utf8');
            fileContent = fileContent
                .replace(/url\(static\//gi, 'url(../')
                .replace(/url\(\/static\//gi, 'url(../');
            fs.writeFileSync(path.resolve('./www/static/css', cssFile), fileContent);
        });
    }
}
