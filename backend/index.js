const express = require('express');
const bodyParser = require('body-parser');
const { exec } = require('child_process');
const dotenv = require('dotenv').config();
const fs = require('fs');
const cors = require('cors');
const app = express();
const port = process.env.PORT || 7800;

// Middleware to parse JSON and URL-encoded data
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Sample route to confirm server is running
app.get('/', (req, res) => {
    res.send("Started successfully");
});

// Function to run Python files
const runPythonFiles = () => {
    return new Promise((resolve, reject) => {
        const pythonFiles = ['../file.py']; // Array of Python files to run
        let completed = 0;

        // Run each file in parallel
        pythonFiles.forEach((file, index) => {
            exec(`python ${file}`, (error, stdout, stderr) => {
                if (error) {
                    console.error(`Error executing ${file}: ${error.message}`);
                    reject(error);
                    return;
                }
                if (stderr) {
                    console.error(`Error in ${file}: ${stderr}`);
                    reject(stderr);
                    return;
                }
                console.log(`Output of ${file}: ${stdout}`);
                completed += 1;

                // Resolve when all files are executed
                if (completed === pythonFiles.length) {
                    resolve('All files executed successfully!');
                }
            });
        });
    });
};

// Route for running Python files
app.get('/start', async (req, res) => {
    try {
        const result = await runPythonFiles();
        console.log('Success:', result);
        res.send('Python files executed successfully!');
    } catch (error) {
        console.error('Error:', error);
        res.status(500).send('Error executing Python files.');
    }
});

// Route to read benchmarks from output.json file
app.get('/benchmarks', (req, res) => {
    const filePath = '../JSON-Reports/output.json'; // Path to your JSON file

    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading the file:', err);
            res.status(500).send('Error reading the benchmark file.');
            return;
        }

        try {
            const benchmarks = JSON.parse(data);
            res.json(benchmarks);
        } catch (parseError) {
            console.error('Error parsing the JSON:', parseError);
            res.status(500).send('Error parsing the benchmark data.');
        }
    });
});

// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
