const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const db = require('./db');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// GET all
app.get('/kitab', (req, res) => {
  db.all('SELECT * FROM kitab', [], (err, rows) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(rows);
  });
});

// GET by ID
app.get('/kitab/:id', (req, res) => {
  db.get('SELECT * FROM kitab WHERE id = ?', [req.params.id], (err, row) => {
    if (err) return res.status(500).json({ error: err.message });
    if (!row) return res.status(404).json({ error: 'Kitab not found' });
    res.json(row);
  });
});

// POST new
app.post('/kitab', (req, res) => {
  const { nama, kategori, penulis } = req.body;
  db.run(
    'INSERT INTO kitab (nama, kategori, penulis) VALUES (?, ?, ?)',
    [nama, kategori, penulis],
    function(err) {
      if (err) return res.status(500).json({ error: err.message });
      res.status(201).json({ id: this.lastID, nama, kategori, penulis });
    }
  );
});

// PUT update
app.put('/kitab/:id', (req, res) => {
  const { nama, kategori, penulis } = req.body;
  db.run(
    'UPDATE kitab SET nama = ?, kategori = ?, penulis = ? WHERE id = ?',
    [nama, kategori, penulis, req.params.id],
    function(err) {
      if (err) return res.status(500).json({ error: err.message });
      if (this.changes === 0) return res.status(404).json({ error: 'Kitab not found' });
      res.json({ id: req.params.id, nama, kategori, penulis });
    }
  );
});

// DELETE
app.delete('/kitab/:id', (req, res) => {
  db.run('DELETE FROM kitab WHERE id = ?', [req.params.id], function(err) {
    if (err) return res.status(500).json({ error: err.message });
    if (this.changes === 0) return res.status(404).json({ error: 'Kitab not found' });
    res.json({ deleted: true });
  });
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));
