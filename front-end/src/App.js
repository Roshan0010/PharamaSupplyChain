import './App.css';
import Login from './pages/Login';
import Home from './pages/Home';
import Header from './components/Header';
import { Routes, Route } from 'react-router-dom';
import Register from './pages/Register';
import RegisterAdmin from './pages/RegisterAdmin';
import { Toaster } from 'react-hot-toast';
function App() {
  return (
    <div className="App h-full">
    <Toaster/>
    <div className='h-[10%] sm:h-[5%] bg-gray-300 overflow-x-hidden ' >
     <Header/>
    </div>

    <div className='h-[90%] w-[100vw] flex justify-center items-center '>
    <Routes>
    <Route path='/' element={<Home/>} />
    <Route path='/home' element={<Home/>} />
      <Route path="/login" element={<Login/>} />
      <Route path="/register-admin" element={<RegisterAdmin/>} />
      <Route path="/register" element={<Register/>} />
      </Routes>
    </div>

    
    </div>
  );
}


export default App;
