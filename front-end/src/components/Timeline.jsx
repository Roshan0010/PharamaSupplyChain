import React from 'react'
import { activities } from '../commonData'
import ProgressBar from './ProgressBar'
const Timeline = ({value}) => {
  return (
    <div className='w-full flex flex-col justify-center items-center'>
    <div className='w-[90%]  flex justify-between'>
     {activities.map((item)=>(
      <span>{item}</span>
     ))}
    </div>
    <div className='w-[90%]  '>
    <ProgressBar value={value} maxValue={5} color="#475569" />
    </div>
    </div>
  )
}

export default Timeline