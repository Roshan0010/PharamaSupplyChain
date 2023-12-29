import React from 'react';
import ShowData from '../components/ShowData';
import Timeline from '../components/Timeline';
import { barValues, ChainData } from '../commonData';

const Distributor = () => {
  // Filter retailers from ChainData based on type
  const retailer = ChainData.filter((item) => item.type === 'retailer');

  // Define input data for ShowData component
  const inputData = ["item name", "Distributor address", "Quantity", "product Id"];

  return (
    <div className='w-full h-full flex flex-col'>
      {/* Display input data using ShowData component */}
      <ShowData inputData={inputData} />
      {/* Display timeline using Timeline component */}
      <Timeline value={barValues[2]} />
      
      <div className='w-full h-full flex gap-4'>
        <div className='w-[50%] h-full'>
          <div className='h-[15%] flex justify-center items-center mt-10'>
            <div className='w-[70%] flex justify-center'>
              <input className='h-10 border rounded-lg w-42 p-2 text-lg focus:bg-gray-200 focus:outline-none' placeholder={`Amount`}  />
              <button className={`w-[30%] ml-6 h-10 border border-slate-500 p-2 rounded-2xl hover:bg-slate-600 hover:text-white text-slate-600`}>
                Pay manufacturer
              </button>
            </div>
          </div>
        </div>
        
        {/* Right panel for assigning retailers */}
        <div className=' w-[50%] mt-10'>
          <div className=' flex justify-center items-center'>
            <div className='w-[100%] flex flex-col border-l-4 border-double justify-center items-center gap-10'>
              {/* Display retailers and assign button */}
              {Array(5).fill().map((_, index) => (
                <div key={index} className='flex '>
                  {/* Dropdown to select retailers */}
                  <select id={`listEntity-${index}`} name={`Entity-${index}`} className="rounded-lg p-2 pr-5 outline-none border ml-6">
                    {retailer.map((item) => (
                      <option key={item.name} className='hei'>{item.name}</option>
                    ))}
                  </select>
                  {/* Assign Retailer button */}
                  <button className={`w-[40%] ml-6 h-10 border border-slate-500 p-2 rounded-2xl hover:bg-slate-600 hover:text-white text-slate-600`}>
                    Assign Retailer
                  </button>
                </div>
              ))}
            </div>
          </div>
          <div className='h-[20%] flex justify-center items-center'>
        <button className='w-[40%] h-10 bg-slate-700 m-5 p-2 text-white rounded-2xl hover:bg-slate-600'>
          Send to Retailers
        </button>
      </div>
        </div>
        
      </div>
    </div>
  );
}

export default Distributor;
