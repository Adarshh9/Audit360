import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom'; // Import useNavigate for redirection
import '../style/Output.css'; // Import the CSS file

const Benchmarks = () => {
  const [benchmarks, setBenchmarks] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const navigate = useNavigate(); // Initialize navigate

  useEffect(() => {
    const fetchBenchmarks = async () => {
      try {
        const response = await axios.get('http://localhost:7800/benchmarks');
        setBenchmarks(response.data);
      } catch (error) {
        setError('Error fetching benchmark data.');
        console.error('There was an error!', error);
      } finally {
        setLoading(false);
      }
    };

    fetchBenchmarks();
  }, []);

  const handleGenerateReport = async () => {
    try {
      navigate('/summary'); // Redirect to /summary
      await axios.get('http://localhost:7800/generate-report');
    } catch (error) {
      console.error('Error generating report:', error);
      setError('Error generating report.');
    }
  };

  if (loading) return <p>Loading...</p>;
  if (error) return <p>{error}</p>;

  // Summary text based on benchmarks
  const summaryText = benchmarks.length > 0
    ? `Total Benchmarks: ${benchmarks.length}`
    : 'No benchmarks to summarize.';

  return (
    <div className="benchmarks-container">
      <h1>Benchmark Dashboard</h1>
      <div className="benchmarks-grid">
        {benchmarks.length > 0 ? (
          benchmarks.map((benchmark, index) => (
            <div key={index} className="benchmark-card">
              <h2>Benchmark {index + 1}</h2>
              <ul>
                {Object.entries(benchmark).map(([key, value]) => (
                  <li key={key}>
                    <strong>{key}:</strong> {value.toString()}
                  </li>
                ))}
              </ul>
            </div>
          ))
        ) : (
          <p>No benchmarks found.</p>
        )}
      </div>
      <button onClick={handleGenerateReport}>Generate Report</button>
    </div>
  );
};

export default Benchmarks;
