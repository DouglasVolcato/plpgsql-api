import { exec } from "child_process";
import { config } from "dotenv";
import { exit } from "process";
import fs from "fs/promises";
import pg from "pg";

const { Pool } = pg;
config();

const pool = new Pool({
  host: "localhost",
  user: process.env.POSTGRES_USER,
  password: process.env.POSTGRES_PASSWORD,
  database: process.env.POSTGRES_DB,
  port: Number(process.env.POSTGRES_PORT),
});

const runSQLFilesWithTransaction = async (client, files) => {
  try {
    await client.query("BEGIN");
    console.log("\n***BEGIN***\n");

    for (const file of files) {
      const filePath = file;
      const sql = await fs.readFile(filePath, "utf-8");

      await client.query(sql);
      console.log(`Executed ${file}`);
    }

    await client.query("COMMIT");
    console.log("\n***COMMIT***\n");
  } catch (error) {
    await client.query("ROLLBACK");
    console.log("\n***ROLLBACK***\n");
    throw error;
  }
};

const getModifiedSQLFiles = async () => {
  return new Promise((resolve, reject) => {
    exec("git diff --name-only origin/main", (err, stdout) => {
      if (err) {
        reject(err);
      } else {
        const modifiedFiles = stdout
          .split("\n")
          .filter((file) => file.endsWith(".sql"));
        resolve(modifiedFiles);
      }
    });
  });
};

(async () => {
  const client = await pool.connect();
  try {
    const modifiedFiles = await getModifiedSQLFiles();
    await runSQLFilesWithTransaction(client, modifiedFiles);
  } catch (error) {
    console.error("Error:", error.message);
  } finally {
    client.release();
    exit();
  }
})();
