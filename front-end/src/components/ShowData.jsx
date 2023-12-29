import React from 'react'

const ShowData = ({inputData}) => {
  
  return (
    <div className='flex w-full  m-4 h-24 gap-3 justify-evenly items-center'>
    {inputData.map((item)=>(
      <p className=' h-10 border rounded-lg w-72 p-2 text-lg ' >{item}</p>
    ))}
   
    </div>
  )
}

export default ShowData