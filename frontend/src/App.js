// App.js
import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import ExecutePythonButton from './Page/Home.js'; // Adjust the path as necessary
import Benchmarks from './Page/Output.js'; // Create this component to display benchmarks

const App = () => {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<ExecutePythonButton />} />
        <Route path="/benchmarks" element={<Benchmarks />} />
      </Routes>
    </Router>
  );
};

export default App;