const admin = require("firebase-admin");
// import admin from 'firebase-admin'
const fcm = require("fcm-notification");
// import fcm from 'fcm-notification';

var serviceAccount = require("../config/push-notification-key.json");

const certPath = admin.credential.cert(serviceAccount);

const FCM = new fcm(certPath);

const sendPushNotification = function (req, res) {
  let message = {
    notification: {
      title: "Wow Fraudulent Alert",
      body: "Someone just stole your 2 million",
    },

    data: {
      orderId: "12345678",
      orderDate: "2022-10-28",
    },
    token: req.body.fcm_token,
  };

  try {
    FCM.send(message, function (err, resp) {
      if (err) {
        return res.send({
          message: err,
        });
      } else {
        return res.status(200).send({
          message: "Notification Sent",
        });
      }
    });
  } catch (err) {
    throw err;
  }
};

module.exports = {
  sendPushNotification,
};
