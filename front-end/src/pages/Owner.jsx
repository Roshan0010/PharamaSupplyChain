import React, { useState } from 'react';
import ItemTableTable from '../components/ItemTable';
import EntityTable from '../components/EntityTable';

const Owner = () => {
  const address = 'x0129fj39mu93f39ff334n44ugj9gu4gu99';
  const [showCreateItem, setShowCreateItem] = useState(false);
  let chain = ['Manufacturer', 'Distributor', 'Retailer', 'Supplier'];
  const infoArray = [
    "Supplier name/Supplier address/Add supplier",
    "Manufacturer name/Manufacturer address/Add manufacturer",
    "Distributor name/Distributor address/Add distributor",
    "Retailer name/Retailer address/Add retailer"
  ];
  

  const toggleCreateItem = () => {
    setShowCreateItem(!showCreateItem);
  };

  return (
    <div className="h-[100%] w-[90%]  flex flex-col items-center gap-5">
      <p className="h-[20%] w-[50%] mt-5 px-3  bg-slate-200 rounded-lg flex items-center text-gray-400">
        {address}
      </p>
      <div className="flex w-full h-full">
        <div className=" w-[50%] border-r-4 border-double  h-full flex flex-col items-center gap-10 ">
          <div className="h-[40%] w-full flex flex-col items-center gap-10">
            {/* {!showCreateItem && ( */}
              <span className={`text-3xl mt-4 transition-opacity ${showCreateItem ? 'fade-out' : 'fade-in'}`}>
                Create a new item
              </span>
            {/* )} */}
            <button
              onClick={toggleCreateItem}
              className={`w-[50%] h-10 bg-slate-700 p-2 mt-36 text-white rounded-2xl hover:bg-slate-600 ${showCreateItem ? 'create-button-up' : 'create-button-down'}`}
            >
              Create
            </button>
            <div
              className={`flex gap-3 h-10  w-full justify-around ${
                showCreateItem ? 'slide-in' : 'slide-out'
              }`}
            >
              {showCreateItem && (
                <>
                  <input
                    type="text"
                    placeholder="item name"
                    className="rounded-xl border border-red-400 pl-2"
                  />
                  <input
                    type="Number"
                    placeholder="item quantity"
                    className="rounded-xl border border-red-400 pl-2"
                  />
                </>
              )}
            </div>
            <button
              className={`w-[30%] h-10 border border-slate-500 p-2   rounded-2xl hover:bg-slate-600 hover:text-white mt-4 text-slate-600 ${
                showCreateItem ? 'slide-in' : 'slide-out'
              }`}
            >
              Create item
            </button>
          </div>
          <div className=" h-[50%] w-full flex flex-col items-center gap-10 ">
          <span className='text-3xl'>List of all items</span>
          <ItemTableTable/>
          </div>
        </div>
        
        <div className="w-[50%]  flex flex-col ">
  <div className='w-full h-[50%]   mt-5 flex flex-col gap-3 items-center justify-center'>
    <div className='flex h-20 w-full   items-center justify-center'>
      <label htmlFor="Entity" className='text-black'>Choose an Entity</label>
      <select id="listEntity" name="Enity" className=" rounded-lg p-2 outline-none border ml-3">
        {chain.map((item) => (
          <option key={item} className='hei'>{item}</option>
        ))}
      </select>
      <button className={`w-[30%] ml-6 h-10 border border-slate-500 p-2 rounded-2xl hover:bg-slate-600 hover:text-white  text-slate-600`}>
        List Entities
      </button>
    </div>
    <div className=' w-[100%]  flex justify-center'>
    <EntityTable />
    </div>
    
  </div>
  <div className='h-[50%] border-t-4 border-double w-full  flex flex-col '>
  <div className='flex justify-center'>
  <span className='h-10 text-lg '>Add Entities</span>
  </div>
   <div className='flex flex-col gap-4 ml-10'>
    {infoArray.map((item)=>{
      const resArr=item.split('/');
      console.log(resArr)
      return(<div className='w-full h-10 flex gap-3 '>
        <input placeholder={`${resArr[0]}`} className='border rounded-lg focus:outline-none'></input>
        <input placeholder={`${resArr[1]}`} className='border rounded-lg focus:outline-none'></input>
        <button className={`w-[30%] h-10 border border-slate-500 p-2 rounded-2xl hover:bg-slate-600 hover:text-white  text-slate-600`}>{resArr[2]}</button>
      </div>)
    })}
    </div> 
    </div>
</div>

      </div>
      
    </div>
  );
};

export default Owner;
