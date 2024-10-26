// App.js
import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import ExecutePythonButton from './Page/Home.js'; // Adjust the path as necessary
import Benchmarks from './Page/Output.js'; // Create this component to display benchmarks
import Gemini from './Page/Gemini.js'

const App = () => {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<ExecutePythonButton />} />
        <Route path="/benchmarks" element={<Benchmarks />} />
        <Route path="/gemini" element={<Gemini />} />
      </Routes>
    </Router>
  );
};

export default App;
