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
// const runPythonFiles = () => {
//     return new Promise((resolve, reject) => {
//         const pythonFiles = ['../audit360.py']; // Array of Python files to run

//         // Run each file in parallel
//         // pythonFiles.forEach((file) => {
//         //     exec(`python3 ${file}`, (error, stdout, stderr) => {
//         //         if (error) {
//         //             console.error(`Error executing ${file}: ${error.message}`);
//         //             reject(error);
//         //             return;
//         //         }
//         //         if (stderr) {
//         //             console.error(`Error in ${file}: ${stderr}`);
//         //             reject(stderr);
//         //             return;
//         //         }

//         //         console.log(`Output of ${file}: ${stdout}`);

//         //         // Since the success is determined by the exit code
//         //         if (stdout.trim().includes("True")) {  // Check if the output indicates completion
//         //             completed += 1;

//         //             // If all files have completed successfully
//         //             if (completed === pythonFiles.length) {
//         //                 resolve('All files executed successfully!');
//         //             }
//         //         } else {
//         //             reject(new Error(`Python script returned unexpected output: ${stdout.trim()}`));
//         //         }
//         //     });
//         // });
//     });
// };


// const runPythonFiles = () => {
//     return new Promise((resolve, reject) => {
//         exec('python3 /home/daksh/Desktop/Mumbai_Hacks/Audit360/audit360.py', (error, stdout, stderr) => {
//             if (error) {
//                 console.error(`Error executing audit360.py: ${error.message}`);
//                 reject(error);
//                 return;
//             }
//             if (stderr) {
//                 console.error(`Error in audit360.py: ${stderr}`);
//                 reject(stderr);
//                 return;
//             }

//             console.log(`Output of audit360.py: ${stdout.trim()}`);

//             // Check the output for "True" or "False"
//             if (stdout.trim() === "True") {
//                 resolve('Python files executed successfully!');
//             } else {
//                 reject(new Error(`Python script returned unexpected output: ${stdout.trim()}`));
//             }
//         });
//     });
// };


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

// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
