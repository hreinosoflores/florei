import React from 'react';
import { Link } from 'react-router-dom';
import { FaChevronDown, FaChevronUp } from "react-icons/fa";
import Search from './Search';
import DropdownSubcat from './DropdownSubcat';

function Navbar() {

    const [ddscabierto, setddscabierto] = React.useState(false);

    const toggle = () => setddscabierto(!ddscabierto);

    return (
        <div className="hidden lg:flex justify-between items-center w-full text-xl text-verde-bosque">
            <ul className="flex justify-start">
                <li className="pr-4"><Link to="/">Inicio</Link></li>
                <li className="flex justify-start items-center pr-4 relative cursor-pointer" onClick={toggle}>
                    <span className="mr-2">Categorías</span>
                    <FaChevronDown className={ddscabierto ? 'hidden' : ''} />
                    <FaChevronUp className={!ddscabierto ? 'hidden' : ''} />
                    <div className="absolute top-8 bg-blanco w-60">
                        <DropdownSubcat abierto={ddscabierto} />
                    </div>
                </li>
                
                <li className="pr-4"><Link to="/contactenos">Contáctenos</Link></li>
            </ul>
            <Search />
        </div>

    )
}

export default Navbar;
