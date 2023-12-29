
import React, { useState } from 'react';
import ShowData from '../components/ShowData';
import Timeline from '../components/Timeline';
import { barValues, ChainData } from '../commonData';

const Customer = () => {
  const retailer = ChainData.filter((item) => item.type === 'retailer');
  const inputData = ["Customer Wallet address"];
  const drugNumber = [1, 2, 3, 4, 5];

  const [isAvailable, setIsAvailable] = useState(false);

  const handleAvailabilityCheck = () => {
    // Perform availability check logic here, and set isAvailable accordingly
    setIsAvailable(true); // For demonstration, setting it true on button click
    // You would have your logic here to determine availability
  };

  return (
    <div className='w-full h-full flex flex-col '>
      {/* ShowData component */}
      <ShowData inputData={inputData} />
      {/* Timeline component */}
      <Timeline value={barValues[4]} />

      {/* Distributor and Supplier sections */}
      <div className='flex flex-col justify-center items-center gap-10 mt-20'>
        <div className='w-[70%] '>
        <div className='h-[15%] flex justify-center items-center mt-10'>
          <div className='w-[100%] flex justify-center'>
            <input className='h-10 border rounded-lg w-42 p-2 text-lg focus:bg-gray-200 focus:outline-none' placeholder={`Amount`} />
            <div className='w-[70%] flex justify-center'>
            <span className='flex items-center mr-6'>Quantity of drug:</span>
            <select className="rounded-lg p-2 pr-5 outline-none border ml-6">
              {drugNumber.map((item) => (
                <option key={item} className='hei'>{item}</option>
              ))}
            </select>
          </div>
          <div className='w-[70%] flex justify-center'>
            <span className='flex items-center mr-6'>Retailer:</span>
            <select className="rounded-lg p-2 pr-5 outline-none border ml-6">

              {retailer.map((item) => (
                <option key={item.id} className='hei'>{item.name}</option>
              ))}
            </select>
          </div>
          </div>
        </div>
      </div>
        <button
          onClick={handleAvailabilityCheck}
          className={`w-[25%]  h-10 border border-slate-500 p-2 rounded-2xl hover:bg-slate-600 hover:text-white text-slate-600`}
        >
          is Available
        </button>

        {isAvailable && (
          <div className='w-[50%] h-20 bg-green-200 m-5 p-2 text-black rounded-2xl animate-bounce'>
            Drug is available
          </div>
        )}

        <div className='w-[50%]  flex justify-center'>
          <div className='h-[15%] w-full flex justify-center items-center mt-10'>
            {/* ... (your existing code) */}
            <button className='w-[50%] h-10 bg-slate-700 m-5 p-2 text-white rounded-2xl hover:bg-slate-600'>
              Buy
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Customer;
