import React from 'react';
import { FaRegUser } from 'react-icons/fa'; 
import {GiMeshBall} from 'react-icons/gi'
import { Link } from 'react-router-dom';


const Header = () => {
  return (
    <div className='flex justify-between items-center h-[100%] bg- mx-3'>
    <Link to={'/home'} className='m-2 text-xl sm:text-2xl lg:text-2xl'>
      <GiMeshBall className='text-4xl sm:text-5xl' />
    </Link>
    <Link to={'/register-product'} className='m-2 text-xl sm:text-2xl lg:text-2xl'>
      Product
    </Link>
    <Link to={'/register'} className='m-2 text-xl sm:text-2xl lg:text-2xl'>
       Chain
    </Link>
    <Link to={'/Login'} className='m-2 text-2xl sm:text-3xl lg:text-3xl '>
      <FaRegUser className='relative top-1' />
    </Link>
  </div>
  
  );
};

export default Header;
