const sqlite3 = require('sqlite3').verbose();
const db = new sqlite3.Database('./kitab.db');

db.serialize(() => {
  db.run(`
    CREATE TABLE IF NOT EXISTS kitab (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nama TEXT NOT NULL,
      kategori TEXT,
      penulis TEXT
    )
  `);
});

module.exports = db;
