import React, { useEffect, useState } from 'react';

const Benchmarks = () => {
    const [benchmarks, setBenchmarks] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        const fetchBenchmarks = async () => {
            try {
                const response = await fetch('http://localhost:7800/benchmarks'); // Adjust if necessary
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                const data = await response.json();
                setBenchmarks(data);
            } catch (error) {
                setError(error.message);
            } finally {
                setLoading(false);
            }
        };

        fetchBenchmarks();
    }, []);

    if (loading) {
        return <div>Loading...</div>;
    }

    if (error) {
        return <div>Error: {error}</div>;
    }

    return (
        <div>
            <h1>Benchmarks Report</h1>
            <h2>Benchmarks Data</h2>
            <pre>{JSON.stringify(benchmarks.benchmarks, null, 2)}</pre>
            <h2>Generated Report</h2>
            <p>{benchmarks.geminiReport}</p>
        </div>
    );
};

export default Benchmarks;
