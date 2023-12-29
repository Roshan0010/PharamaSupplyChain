import React from 'react';
import ShowData from '../components/ShowData';
import Timeline from '../components/Timeline';
import { barValues} from '../commonData';

const Retailer = () => {
  const inputData = ["item name", "Retailer address", "Quantity", "product Id"];
  const drugNumber = [1, 2, 3, 4, 5];

  return (
    <div className='w-full h-full flex flex-col '>
      {/* ShowData component */}
      <ShowData inputData={inputData} />
      {/* Timeline component */}
      <Timeline value={barValues[3]} />

      {/* Distributor and Supplier sections */}
      <div className='flex flex-col justify-center items-center gap-10 mt-20'>
        {/* Distributor section */}
        <div className='w-[50%] '>
          <div className='h-[15%] flex justify-center items-center mt-10'>
            <div className='w-[70%] flex justify-center'>
              {/* Input field and Pay Distributor button */}
              <input className='h-10 border rounded-lg w-42 p-2 text-lg focus:bg-gray-200 focus:outline-none' placeholder={`Amount`} />
              <button className={`w-[30%] ml-6 h-10 border border-slate-500 p-2 rounded-2xl hover:bg-slate-600 hover:text-white text-slate-600`}>
                Pay Distributor
              </button>
            </div>
          </div>
        </div>

        {/* Supplier section */}
        <div className='w-[50%]  flex justify-center'>
          <div className='h-[15%] w-full flex justify-center items-center mt-10'>
            <div className='w-[70%] flex justify-center'>
              {/* Supplier label and dropdown */}
              <span className='flex items-center mr-6'>Quantity of drug:</span>
              <select className="rounded-lg p-2 pr-5 outline-none border ml-6">
                {/* Render drugNumber options */}
                {drugNumber.map((item) => (
                  <option key={item} className='hei'>{item}</option>
                ))}
              </select>
            </div>
            {/* Send to Retailers button */}
            <button className='w-[50%] h-10 bg-slate-700 m-5 p-2 text-white rounded-2xl hover:bg-slate-600'>
              Send to Retailers
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Retailer;
