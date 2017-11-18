const pg = require('pg');
const connectionString = process.env.DATABASE_URL || 'postgres://localhost:5432/botflow';

const client = new pg.Client(connectionString);
client.connect();


var showTasks = function (callback) {
client.query(`SELECT * FROM tasks`, (err, rows, fields) => {
    if(err) {
      callback(err, null);
    } else {
      callback(null, rows);
    }
  });

}

var showMembers = function (callback) {
client.query(`SELECT * FROM users`, (err, rows, fields) => {
    if(err) {
      callback(err, null);
    } else {
      callback(null, rows);
    }
  });

}







//
// let connection = pg.createConnection({
//   host     : 'localhost',
//   user     : 'root',
//   password : 'guapocb1234',
//   database : 'buyfoot'
// });
//
// connection.connect();
//
//
// // var insertDeal = function (table, callback) {
// //   connection.query(`INSERT INTO ${table}`, function (err, rows, fields) {
// //     if (err) {
// //       // throw err;
// //       callback(err, null);
// //     } else {
// //       callback(null, rows);
// //     }
// //     // console.log('Restaraunt name is: ', rows[0].name)
// //   })
// // };
//
//
// var queryAll = function (table, callback) {
//   connection.query(`SELECT * FROM ${table}`, function (err, rows, fields) {
//     if (err) {
//       // throw err;
//       callback(err, null);
//     } else {
//       callback(null, rows);
//     }
//     // console.log('Restaraunt name is: ', rows[0].name)
//   })
// };
//
// var queryAllDeals = function (callback) {
// connection.query(`SELECT A.id AS vendor_id, B.id AS vendor_deal_id, A.name AS restaurant_name, A.address, A.lat, A.lon, B.name as deal_name, B.description AS deal_description, B.price
//   FROM vendor A LEFT JOIN deal B ON A.id = B.vendor_id`, (err, rows, fields) => {
//     if(err) {
//       callback(err, null);
//     } else {
//       callback(null, rows);
//     }
//   });
//
// }




// var queryTasks = function (table, callback) {
//   client.query(`SELECT * FROM ${table}`, function (err, rows, fields) {
//     if (err) {
//       // throw err;
//       callback(err, null);
//     } else {
//       callback(null, rows);
//     }
//     // console.log('Restaraunt name is: ', rows[0].name)
//   })
// };

module.exports = {
 showTasks: showTasks,
 showMembers : showMembers
 // queryTasks: queryTasks
};
