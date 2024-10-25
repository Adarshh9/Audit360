// ExecutePythonButton.js
import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom'; // Import useNavigate for navigation

const ExecutePythonButton = () => {
  const [message, setMessage] = useState('');
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate(); // Initialize useNavigate

  const handleClick = async () => {
    setLoading(true);
    try {
      // Send a GET request to the backend server
      const response = await axios.get('http://localhost:7800/start');
      
      // Set the message based on the response from the server
      setMessage(response.data);
      
      // Navigate to the benchmarks page if execution is successful
      if (response.data.includes('successfully')) {
        navigate('/benchmarks'); // Redirect to benchmarks page
      }
    } catch (error) {
      // Handle any errors
      setMessage('Error executing Python files.');
      console.error('There was an error!', error);
    } finally {
      setLoading(false);
    }
  };

  // Styles as JavaScript objects
  const containerStyle = {
    textAlign: 'center',
    backgroundColor: '#ffffff',
    borderRadius: '10px',
    boxShadow: '0 2px 10px rgba(0, 0, 0, 0.1)',
    padding: '30px',
    width: '300px',
    margin: 'auto'
  };

  const buttonStyle = {
    backgroundColor: loading ? '#a5d6a7' : '#4caf50',
    color: 'white',
    border: 'none',
    borderRadius: '5px',
    padding: '12px 20px',
    fontSize: '16px',
    cursor: loading ? 'not-allowed' : 'pointer',
    transition: 'background-color 0.3s'
  };

  const messageStyle = {
    marginTop: '20px',
    fontSize: '16px',
    color: message.includes('Error') ? '#d32f2f' : '#555'
  };

  return (
    <div style={containerStyle}>
      <button onClick={handleClick} disabled={loading} style={buttonStyle}>
        {loading ? 'Executing...' : 'Execute Python Script'}
      </button>
      {message && <p style={messageStyle}>{message}</p>}
    </div>
  );
};

export default ExecutePythonButton;
