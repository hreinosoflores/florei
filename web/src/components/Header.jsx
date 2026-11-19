import React from 'react';
import Dropdown from './Dropdown';
import Navbar from './Navbar';
import logo from '../img/logo.jpeg';
import { FaBars } from "react-icons/fa";
import { Link } from 'react-router-dom';

function Header() {

    const [ddabierto, setddabierto] = React.useState(false);

    const toggle = () => setddabierto(!ddabierto);

    React.useEffect(() => {
        const hideMenu = () => { if (window.innerWidth >= 1024 && ddabierto) setddabierto(false) };
        window.addEventListener('resize', hideMenu);
        return () => window.removeEventListener('resize', hideMenu);
    });

    return (
        <header className="shadow bg-blanco mb-6 fixed w-full">
            <div className="flex justify-between items-center w-11/12 mx-auto">
                <Link to="/"> <img src={logo} alt="logo" className="w-60 lg:w-72" /></Link>
                <FaBars
                    className="h-8 w-8 text-verde-bosque border-2 border-gris-claro rounded p-1 lg:hidden"
                    onClick={toggle} />
                <Navbar />
            </div>
            <Dropdown abierto={ddabierto} />
        </header>
    )
}

export default Header;
