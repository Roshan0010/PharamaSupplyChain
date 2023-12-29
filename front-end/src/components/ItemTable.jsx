import React from 'react'

const ItemTableTable = ({showCss=true}) => {

    const items = [
        {
          itemName: "Product A",
          quantity: 3,
          id: "ABC123"
        },
        {
          itemName: "Product B",
          quantity: 7,
          id: "DEF456"
        },
        {
          itemName: "Product C",
          quantity: 2,
          id: "GHI789"
        },
        {
          itemName: "Product D",
          quantity: 5,
          id: "JKL012"
        },
        {
          itemName: "Product E",
          quantity: 1,
          id: "MNO345"
        },
        {
          itemName: "Product F",
          quantity: 4,
          id: "PQR678"
        },
        {
          itemName: "Product G",
          quantity: 9,
          id: "STU901"
        },
        {
          itemName: "Product H",
          quantity: 6,
          id: "VWX234"
        },
        {
          itemName: "Product I",
          quantity: 2,
          id: "YZA567"
        },
        {
          itemName: "Product J",
          quantity: 8,
          id: "BCD890"
        },
        {
          itemName: "Product K",
          quantity: 12,
          id: "EFG123"
        },
        {
          itemName: "Product L",
          quantity: 3,
          id: "HIJ456"
        },
        {
          itemName: "Product M",
          quantity: 6,
          id: "KLM789"
        },
        {
          itemName: "Product N",
          quantity: 10,
          id: "OPQ012"
        },
        {
          itemName: "Product O",
          quantity: 4,
          id: "RST345"
        }
      ];
    const rowArray=["Sl.no","Item Name", "Quality","Id","Button"]
    const Row=()=>{
        let serialNumber=1;
        return (
      
        <div className=' h-full w-full'>
          {
            items.map((item)=>(
              <div className='flex'>
              <div className='w-[20%] p-2 border border-slate-500 '>{serialNumber++}</div>
              <div className='w-[20%] p-2 border border-slate-500 '>{item.itemName.slice(0,15)} </div>
              <div className='w-[20%] p-2 border border-slate-500 '>{item.quantity} </div>
              <div className='w-[20%] p-2 border border-slate-500 '>{item.id} </div>  
              <button className='w-[20%] border border-violet-800'>Monitor</button>
              {/* link karna hai  */}
                
                
              </div>
            ))
          }
        </div>
       )
        
      }

  return (
    
    <div className={`w-[100%] h-[57%] overflow-y-scroll flex justify-center ${showCss} `}>
    <div className='w-[75%]  '>
      <div className='flex'>
        {rowArray.map((item)=>(
          <div className='w-[20%] px-1 border border-slate-500'>{item}</div>
        ))}
      </div>
      <Row className="bg-yellow-400 overflow-y-scroll h-full w-full "/>
    </div>
    </div>
    
  )
}

export default ItemTableTable