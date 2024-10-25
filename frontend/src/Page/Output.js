// Benchmarks.js
import React, { useEffect, useState } from 'react';
import axios from 'axios';

const Benchmarks = () => {
  const [benchmarks, setBenchmarks] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

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

  if (loading) return <p>Loading...</p>;
  if (error) return <p>{error}</p>;

  return (
    <div>
      <h1>Benchmark Data</h1>
      <pre>{JSON.stringify(benchmarks, null, 2)}</pre> {/* Format data for display */}
    </div>
  );
};

export default Benchmarks;
