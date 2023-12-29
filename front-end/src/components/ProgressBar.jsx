import React, { useEffect, useState } from 'react';

const ProgressBar = ({ value, maxValue, color }) => {
  const [progress, setProgress] = useState(0);

  useEffect(() => {
    var percentage = (value / maxValue) * 100;
    if(value==0)percentage=5;
    const interval = setInterval(() => {
      setProgress((prevProgress) => {
        if (prevProgress >= percentage) {
          clearInterval(interval);
          return percentage;
        }
        return prevProgress + 1;
      });
    }, 20);

    return () => {
      clearInterval(interval);
    };
  }, [value, maxValue]);

  return (
    <div className="progress-bar-container bg-slate-200">
      <div
        className="progress-bar "
        style={{
          width: `${progress}%`,
          backgroundColor: color,
          borderRadius: progress === 100 ? '10px' : '0 60px 60px 0', 
        }}
      >
        
      </div>
    </div>
  );
};

export default ProgressBar;

