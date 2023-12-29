import React from 'react'

const EntityTable = () => {
    const rowArray=["Sl.no","Entitiy name" , "address"]
    const items = [
        { name: 'John Doe', address: '0xAbCdEf0123456789' },
        { name: 'Alice Smith', address: '0x1234567890abcdef' },
        { name: 'Bob Johnson', address: '0x9876543210abcdef' },
        { name: 'Emily Davis', address: '0x567890abcdef1234' },
        { name: 'Michael Wilson', address: '0xdef0123456789abc' }
      ];
    const Row=()=>{
        let serialNumber=1;
        return (
      
        <div className=' h-full w-full'>
          {
            items.map((item)=>(
              <div className='flex'>
              <div className='w-[33.33%] p-2 border border-slate-500 '>{serialNumber++}</div>
              <div className='w-[33.33%] p-2 border border-slate-500 '>{item.name.slice(0,15)} </div>
              <div className='w-[33.33%] p-2 border border-slate-500 '>{item.address.slice(0,10)}... </div>  
              {/* link karna hai  */}
                
                
              </div>
            ))
          }
        </div>
       )
        
      }

  return (
    <div className=' w-[75%]  h-full overflow-y-scroll flex '>
    <div className='w-full item-center  '>
      <div className='flex'>
        {rowArray.map((item)=>(
          <div className='w-[33.33%] px-1 border border-slate-500'>{item}</div>
        ))}
      </div>
      <div>
        
      </div>
      <Row />
    </div>
    </div>
  )
}

export default EntityTable;