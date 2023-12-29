import './App.css';
import Login from './pages/Login';
import Home from './pages/Home';
import Header from './components/Header';
import { Routes, Route } from 'react-router-dom';
import Register from './pages/Register';
import RegisterAdmin from './pages/RegisterAdmin';
import { Toaster } from 'react-hot-toast';
import Owner from './pages/Owner';
import Monitor from './pages/Monitor';
import Distributor from './pages/Distributor';
import Manufacturer from './pages/Manufacturer';
import Retailer from './pages/Retailer';
import Customer from './pages/Customer';

function App() {
  return (
    <div className=" h-full">
    <Toaster/>
    <div className='h-[10vh] w-[100vw] overflow-x-hidden ' >
     <Header/>
    </div>

    <div className='h-[90vh] w-[100vw]  flex justify-center items-center '>
    <Routes>
    <Route path='/' element={<Home/>} />
    <Route path='/home' element={<Home/>} />
      <Route path="/login" element={<Login/>} />
      <Route path="/register-admin" element={<RegisterAdmin/>} />
      <Route path="/register" element={<Register/>} />
      <Route path="/owner" element={<Owner/>} />
      <Route path="/monitor" element={<Monitor/>} />
      <Route path="/manufacturer" element={<Manufacturer/>} />
      <Route path="/distributor" element={<Distributor/>} />
      <Route path="/retailer" element={<Retailer/>} />
      <Route path="/customer" element={<Customer/>} />
      
      </Routes>
    </div>

    
    </div>
  );
}


export default App;
