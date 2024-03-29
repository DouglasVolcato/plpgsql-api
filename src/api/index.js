import bodyParser from "body-parser";
import { config } from "dotenv";
import express from "express";
import cors from "cors";
config();

const app = express();
app.use(cors());
app.use(bodyParser.json());

app.get("/", (req, res) => {
  res.send("Working");
});

const port = process.env.API_PORT || 3000;
app.listen(port, () => {
  console.log(`http://localhost:${port}`);
});
