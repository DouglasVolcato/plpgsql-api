import bodyParser from "body-parser";
import { config } from "dotenv";
import express from "express";
import cors from "cors";
import pg from "pg";
const { Pool } = pg;

config();
const app = express();
app.use(cors());
app.use(bodyParser.json());

const pool = new Pool({
  host: process.env.POSTGRES_HOST,
  user: process.env.POSTGRES_USER,
  password: process.env.POSTGRES_PASSWORD,
  database: process.env.POSTGRES_DB,
  port: Number(process.env.POSTGRES_PORT),
});

const client = await pool.connect();
const result = await client.query("SELECT * FROM fc_router()");

await Promise.all(
  result.rows.map(async (route) => {
    app[route.type](route.path, async (req, res) => {
      try {
        const data = JSON.stringify({
          ...req.body,
          ...req.query,
          ...req.params,
        });
        const result = await client.query(
          `SELECT * FROM ${route.function}($1)`, [data]
        );
        res.status(200).send(result);
      } catch (error) {
        res.status(500).send(error);
      }
    });
  })
).then(() => {
  const port = process.env.PORT || 3000;
  app.listen(port, () => {
    console.log(`http://localhost:${port}`);
  });
});
