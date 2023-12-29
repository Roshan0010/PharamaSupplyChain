import React, { useState } from 'react';
import ItemTable from '../components/ItemTable';

const Home = () => {
  const [data, setData] = useState("MetaMask Address is");
  const [showTable, setShowTable] = useState(false);

  const toggleTable = () => {
    
    setShowTable(!showTable);
    console.log(showTable);
  };

  return (
    <div className="h-[90%] w-[70%] mt-10 flex flex-col items-center gap-10">
      <p className="h-10 w-[50%] mt-5 px-3 bg-slate-200 rounded-lg flex items-center text-gray-400">
        {data}
      </p>
      <button
        className="w-[30%] h-[8%] bg-slate-700 p-2 text-white rounded-2xl hover:bg-slate-600"
        onClick={toggleTable}
      >
        List
      </button>
      <ItemTable showCss={showTable ? 'table-container-show' : 'table-container'} />
    </div>
  );
};

export default Home;
