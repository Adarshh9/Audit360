const express = require('express');
const bodyParser = require('body-parser');
const { exec } = require('child_process');
const dotenv = require('dotenv').config();
const fs = require('fs');
const path = require('path');
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



function executeAudit() {
    return new Promise((resolve, reject) => {
        const pythonScriptPath = ('/home/daksh/Desktop/Mumbai_Hacks/Audit360/audit360.py'); // Update the path if needed

        exec(`python3 "${pythonScriptPath}" 2>/dev/null`, { cwd: '/home/daksh/Desktop/Mumbai_Hacks/Audit360' }, (error, stdout, stderr) => {
            if (error) {
                console.error(`Error executing script: ${error.message}`);
                return reject(`Execution Error: ${error.message}`);
            }

            if (stderr) {
                console.error(`Script error: ${stderr}`);
                return reject(`Script Error: ${stderr}`);
            }

            const result = stdout.trim() === "True";
            resolve(result);
        });
    });
}

app.get('/start', async (req, res) => {
    try {
        const result = await executeAudit();
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


// app.post('/summary_report', (req, res) => {
//     const filepath = 
// })

// trigger.js
// const { exec } = require('child_process');

// Specify the path to your output.json file
app.get('/generate-report', (req, res) => {
    // Specify the path to your JSON file
    const filePath = '../JSON-Reports/output.json'; // Adjust path as necessary
    console.log("Hit")
    // Call the Python script with the file path
    

    // Specify the path to your output.json file
   
    exec(`python3 genai.py "${filePath}"`, (error, stdout, stderr) => {
        if (error) {
            console.error(`Error executing script: ${error.message}`);
            return;
        }
        if (stderr) {
            console.error(`Script error: ${stderr}`);
            return;
        }
        console.log(`Output from Python script: ${stdout}`);
    });


    exec(`python3 mitigate.py "${filePath}"`, (error, stdout, stderr) => {
        if (error) {
            console.error(`Error executing script: ${error.message}`);
            return;
        }
        if (stderr) {
            console.error(`Script error: ${stderr}`);
            return;
        }
        console.log(`Output from Python script: ${stdout}`);
    });
});


app.get('/read-file-1', (req, res) => {
    const filePath = path.join(__dirname, 'threats.txt');
    
    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            return res.status(500).send('Error reading file 1');
        }
        res.send(data);
    });
});

// Endpoint to read and send the content of the second txt file
app.get('/read-file-2', (req, res) => {
    const filePath = path.join(__dirname, 'mitigation.txt');
    
    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            return res.status(500).send('Error reading file 2');
        }
        res.send(data);
    });
});

// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
