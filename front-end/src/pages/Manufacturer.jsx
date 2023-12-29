import React from 'react';
import ShowData from '../components/ShowData';
import { barValues, ChainData } from '../commonData';
import Timeline from '../components/Timeline';

const Manufacturer = () => {
  const supplier = ChainData.filter((item) => item.type === 'supplier');
  const inputData=["item name","Manufacturer address","Quantity","product Id"];

  return (
    <div className='w-full h-full flex flex-col gap-4'>
      <ShowData inputData={inputData} />
      <Timeline value={barValues[1]} />
      
      <div className='h-[15%] flex justify-center items-center'>
        <div className='w-[50%] flex justify-center'>
          <span className='flex items-center mr-6'>Supplier:</span>
          <select id="listEntity" name="Entity" className="rounded-lg p-2 outline-none border ml-6">
            {supplier.map((item) => (
              <option key={item.name} className='hei'>{item.name}</option>
            ))}
          </select>
          <button className={`w-[30%] ml-6 h-10 border border-slate-500 p-2 rounded-2xl hover:bg-slate-600 hover:text-white text-slate-600`}>
            Assign Supplier
          </button>
        </div>
      </div>

      <div className='h-[15%] flex justify-center items-center'>
        <div className='w-[50%] flex justify-center'>
        <input className=' h-10 border rounded-lg w-42 p-2 text-lg focus:bg-gray-200 focus:outline-none' placeholder={`Amount`}  />
          <button className={`w-[30%] ml-6 h-10 border border-slate-500 p-2 rounded-2xl hover:bg-slate-600 hover:text-white text-slate-600`}>
           Pay Supplier
          </button>
        </div>
      </div>
      


      <div className='h-[15%] flex justify-center items-center'>
        <div className='w-[50%] flex justify-center'>
        <input className=' h-10 border rounded-lg w-42 p-2 ml-3 text-lg focus:bg-gray-200 focus:outline-none' placeholder={`Manufacturing Date`}  />
        <input className=' h-10 border rounded-lg w-42 p-2 text-lg ml-4 focus:bg-gray-200 focus:outline-none' placeholder={`Expiring Date`}  />
          <button className={`w-[30%] ml-6 h-10 border border-slate-500 p-2 rounded-2xl hover:bg-slate-600 hover:text-white text-slate-600`}>
            Start Manufacturer
          </button>
        </div>
      </div>

      

      <div className='h-[20%] flex justify-center items-center'>
      <input className=' h-10 border rounded-lg w-42 p-2 text-lg ml-4 focus:bg-gray-200 focus:outline-none' placeholder={`Drug Price`}  />
        <button className='w-[20%] h-10 bg-slate-700 m-5 p-2 text-white rounded-2xl hover:bg-slate-600'>
          Send to distributor
        </button>
      </div>
    </div>
  );
};

export default Manufacturer;
