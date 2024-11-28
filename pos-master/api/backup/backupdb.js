const fs = require("fs");
const spawn = require("child_process").spawn;
const { exec } = require("child_process");
const path = require("path");
const multer = require("multer");
const deleteFile = require("../middlewares/deleteImage");

const location = path.basename("./dbbackup");

// =========== get file upload from client =======
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./dbbackup");
  },
  filename: (req, file, cb) => {
    //console.log(file.originalname.split("."));
    cb(null, Date.now() + file.originalname);
  },
});

const upload = multer({
  storage: storage,
}).single("dbbackup");

module.exports.upload = async (req, res, next) => {
  upload(req, res, function (err) {
    if (err) {
      res.send(err);
    } else {
      // SUCCESS, image successfully uploaded
      next();
    }
  });
};

// ============ end ======================

module.exports.backup = async (req, res, next) => {
  const location = path.basename("./dbbackup");
  const wstream = fs.createWriteStream(
    location + `/${process.env.DB_NAME}.sql`
  );
  const mysqldumpPath = 'D:/wamp64/bin/mysql/mysql5.7.36/bin/mysqldump';
  const mysqldump = spawn(mysqldumpPath, [
    "-u",
    process.env.DB_USER,
    process.env.DB_NAME,
  ]);
  mysqldump.stdout
    .pipe(wstream)
    .on("finish", function () {
      console.log("Completed");
      //console.log(location + `/${process.env.DB_NAME}.sql`);
      res.download(location + `/${process.env.DB_NAME}.sql`);
    })
    .on("error", function (err) {
      res.send(err);
      console.log(err);
    });
};

// module.exports.restore = async (req, res, next) => {
//   //console.log(req.file);
//   const mysqlPath = "D:/wamp64/bin/mysql/mysql5.7.36/bin/mysql";
//   if (req.file) {
//     const filePath = req.file.path.replace(/\\/g, "/"); // Replace backslashes with forward slashes in file path
//     exec(
//       `${mysqlPath} -u ${process.env.DB_USER} -h ${process.env.DB_HOST} ${process.env.DB_NAME} < '${filePath}'`,
//       (err, stdout, stderr) => {
//         if (err) {
//           console.error(`exec error: ${err}`);
//           next(err);
//           return;
//         }
//         deleteFile(filePath);
//         res.send({
//           message: "Data has been restored successfully.",
//           success: true,
//         });
//         console.log(`The import has finished.`);
//       }
//     );
//   } else {
//     if (fs.existsSync(location + `/${process.env.DB_NAME}.sql`)) {
//       exec(
//         `mysql -u ${process.env.DB_USER} -h ${process.env.DB_HOST} ${
//           process.env.DB_NAME
//         } < ${location + `/${process.env.DB_NAME}.sql`}`,
//         (err, stdout, stderr) => {
//           if (err) {
//             console.error(`exec error: ${err}`);
//             next(err);
//             return;
//           }
//           deleteFile(location + `/${process.env.DB_NAME}.sql`);
//           res.send({
//             message: "Data has been restored successfully.",
//             success: true,
//           });
//           console.log(`The import has finished.`);
//         }
//       );
//     } else {
//       res.send({ message: `Not found backup file.`, success: false });
//     }
//   }
// };
//


module.exports.restore = async (req, res, next) => {
  const mysqlPath = "D:/wamp64/bin/mysql/mysql5.7.36/bin/mysql";
  const location = "your/backup/location";

  if (req.file) {
    const filePath = req.file.path.replace(/\\/g, "/");

    exec(
      `"${mysqlPath}" -u ${process.env.DB_USER} -h ${process.env.DB_HOST} ${process.env.DB_NAME} < "${filePath}"`,
      (err, stdout, stderr) => {
        if (err) {
          console.error(`exec error: ${err}`);
          next(err);
          return;
        }
        deleteFile(filePath);
        res.send({
          message: "Data has been restored successfully.",
          success: true,
        });
        console.log(`The import has finished.`);
      }
    );
  } else {
    const backupFilePath = path.join(location, `${process.env.DB_NAME}.sql`);

    if (fs.existsSync(backupFilePath)) {
      exec(
        `"${mysqlPath}" -u ${process.env.DB_USER} -h ${process.env.DB_HOST} ${process.env.DB_NAME} < "${backupFilePath}"`,
        (err, stdout, stderr) => {
          if (err) {
            console.error(`exec error: ${err}`);
            next(err);
            return;
          }
          deleteFile(backupFilePath);
          res.send({
            message: "Data has been restored successfully.",
            success: true,
          });
          console.log(`The import has finished.`);
        }
      );
    } else {
      res.send({ message: "Backup file not found.", success: false });
    }
  }
};
