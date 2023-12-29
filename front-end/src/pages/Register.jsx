import axios from 'axios';
import React, { useState } from 'react';
import { NavLink } from 'react-router-dom';
import Dropdown from 'react-dropdown';
import ConnMetaMask from '../components/ConnMetaMask';
import showToast from '../components/HandleToast';
import toast from 'react-hot-toast';


const Register = () => {
  const [name, setname] = useState('');
  const [isConMeta,setIsConMeta] = useState(false);
  const [chainPerson,setChainPerson]=useState('manufacturer');
 

//   async function RegisterUser(e) {
//     try {
//       e.preventDefault();
//       await axios.post('/register', {
//         name,
//         email,
//         password
//       });
//       toast.success('Successfully registered');
//     } catch (e) {
//       toast.error('User already exists, try Login');
//     }
//   }
//onSubmit={RegisterUser}

async function ConnectMetamask(){

  setIsConMeta(true);

}
function handleSubmit(e){
  e.preventDefault();
  if(chainPerson.length && name.length){
    if(isConMeta){
      try{
        // await
        showToast('Successfully registered '+chainPerson,true);
       }
       catch(e){
         showToast ('Unable to register server error',false);
       }
    }
    else{
      showToast ('Please Connect to Metamask',false);
    }

   
  }
  else{
    showToast ('Please Fill all the fields',false);
  }
  setChainPerson('');
}
function handleChainPersonSelect(e){
  console.log(chainPerson);
  setChainPerson(e.target.value)
  console.log(chainPerson);
}




  return (
    <div className='lg:w-[65%] sm:w-[100%] h-[100%]  flex justify-center p-16 mt-32'>
  <div className='flex flex-col  p-1 lg:w-7/12 h-1/4 justify-evenly'>
    <p className='text-center   text-4xl mb-4 '>Register Chain</p>
    <form className='flex flex-col' onSubmit={handleSubmit}>
      <input
        type='text'
        placeholder='your name'
        className='border border-[#EFEEEF] rounded-2xl px-4 py-2 mb-2'
        value={name}
        onChange={(e) => setname(e.target.value)}
      ></input>

      <div className=''>
        <select
          className='w-full border border-[#EFEEEF] rounded-2xl px-4 py-2 mb-2 '
          onChange={handleChainPersonSelect}
        >
          <option value='manufacturer'>Manufacturer</option>
          <option value='logistics'>Logistics</option>
          <option value='distributor'>Distributor</option>
          <option value='supplier'>Supplier</option>
          <option value='retailer'>Retailer</option>
        </select>
      </div>

      <ConnMetaMask isConMeta={isConMeta} setIsConMeta={setIsConMeta} />

      <button className='w-[100%] bg-slate-800 p-2 text-white rounded-2xl hover:bg-slate-600'>
        Register
      </button>
    </form>
  </div>
</div>

  );
};

export default Register;
