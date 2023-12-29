import React from 'react'
import ShowData from '../components/ShowData';
import {barValues } from '../commonData';
import Timeline from '../components/Timeline';
import { ChainData } from '../commonData';
const monitoring = () => {
const supplierAddress="Supplier not yet assigned"
  const inputData=["item name","quantity","product id"];
  const manufacturerData = ChainData.filter((item) => item.type === "manufacturer");
  const Distributor = ChainData.filter((item) => item.type === "distributor");

  console.log(manufacturerData)
  return (
    <div className=' w-full h-full flex flex-col gap-4 ' >
    <ShowData inputData={inputData}/>
   <Timeline value={barValues[0]}/>
   <div className='h-[20%]  flex justify-center items-center '>
   <div className=' w-[50%] flex justify-center  '>
    <span className='flex items-center mr-4'>Supplier:</span>
    <div className=' h-10 border  rounded-lg w-72 p-2 text-gray-500 focus:bg-gray-200 '>{supplierAddress}</div>
    </div>
   </div>
   <div className='h-[20%]  flex justify-center items-center '>
   <div className=' w-[50%] flex justify-center  '>
    <span className='flex items-center mr-4'>Manufacturer:</span>
   
    <select id="listEntity" name="Enity" className=" rounded-lg p-2 outline-none border ml-3">
        {manufacturerData.map((item) => (
          <option key={item.name} className='hei'>{item.name}</option>
        ))}
      </select>
      <button className={`w-[30%] ml-6 h-10 border border-slate-500 p-2 rounded-2xl hover:bg-slate-600 hover:text-white  text-slate-600`}>
        Assign Manufaturer
      </button>
    </div>
   </div>
   <div className='h-[20%]  flex justify-center items-center  '>
   <div className=' w-[50%] flex justify-center  '>
    <span className='flex items-center mr-6'>Distributor:</span>
   
    <select id="listEntity" name="Enity" className="rounded-lg p-2 outline-none border ml-6">
        {Distributor.map((item) => (
          <option key={item.name} className='hei'>{item.name}</option>
        ))}
      </select>
      <button className={`w-[30%] ml-6 h-10 border border-slate-500 p-2 rounded-2xl hover:bg-slate-600 hover:text-white  text-slate-600`}>
        Assign Distributor
      </button>
    </div>
   </div>
   <div className='h-[20%]  flex justify-center items-center  '>
   <button   className=' w-[20%]  h-10 bg-slate-700 m-5 p-2  text-white rounded-2xl hover:bg-slate-600 '>Send to manufacturer</button>
   </div>

  

   
   
    </div>
  )
}

export default monitoring

{/*  */}