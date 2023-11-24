import React from 'react';
import { FaRegUser } from 'react-icons/fa'; 
import {GiMeshBall} from 'react-icons/gi'
import { Link } from 'react-router-dom';


const Header = () => {
  return (
    <div className='flex justify-between items-center h-[100%] '>
      <Link to={'/home'} className='m-6 text-2xl'>
      <GiMeshBall className='text-5xl' />
      </Link>
      <Link to={'/register-product'} className='m-6 text-2xl'> 
      
      Register Product
      </Link>
      <Link to={'/register'} className='m-6 text-2xl'> 
      Register Chain
      </Link>

      <Link to={'/Login'} className='m-6 text-3xl'>
      <FaRegUser className='relative top-1' />
      </Link>
    </div>
  );
};

export default Header;
