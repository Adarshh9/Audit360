import React, { useEffect, useState } from 'react';

function App() {
    const [fileContent1, setFileContent1] = useState('');
    const [fileContent2, setFileContent2] = useState('');

    useEffect(() => {
        // Fetch content of the first file
        fetch('http://localhost:7800/read-file-1')
            .then((response) => response.text())
            .then((data) => {
                setFileContent1(data);
            })
            .catch((error) => console.error('Error fetching file 1:', error));
        
        // Fetch content of the second file
        fetch('http://localhost:7800/read-file-2')
            .then((response) => response.text())
            .then((data) => {
                setFileContent2(data);
            })
            .catch((error) => console.error('Error fetching file 2:', error));
    }, []);

    return (
        <div className="App">
            <h1>Threats:</h1>
            <pre>{fileContent1}</pre>

            <h1>Mitigation</h1>
            <pre>{fileContent2}</pre>
        </div>
    );
}

export default App;
