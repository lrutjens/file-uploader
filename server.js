const express = require('express');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const cors = require('cors');

const app = express();
const PORT = 3000;


app.use(cors());


const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const uploadDir = path.join(__dirname, 'uploads');
    
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir);
    }
    cb(null, uploadDir);
  },
  filename: (req, file, cb) => {
    
    cb(null, Date.now() + '-' + file.originalname);
  },
});

const upload = multer({ storage });


app.use(express.static('public'));


app.post('/upload', upload.single('filepond'), (req, res) => {
  
  if (!req.file) {
    return res.status(400).send('No file uploaded.');
  }

  res.status(200).send({
    message: 'File uploaded successfully',
    filename: req.file.filename,
  });
});


app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server is running on http://0.0.0.0:${PORT}`);
});
