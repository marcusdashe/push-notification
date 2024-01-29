const express = require("express");
const app = express();

app.use(express.json());

app.use("/api", require("./routes/app.routes"));

app.listen(8000, () =>
  console.log("Web Service Listening on http://localhost:8000")
);
