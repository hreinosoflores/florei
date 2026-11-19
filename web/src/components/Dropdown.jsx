import React from 'react';
import { Link } from 'react-router-dom';
import { FaChevronDown, FaChevronUp } from "react-icons/fa";
import Search from './Search';
import DropdownSubcat from './DropdownSubcat';
import PropTypes from "prop-types";

function Dropdown(props) {

    const [ddscabierto, setddscabierto] = React.useState(false);

    const toggle = () => setddscabierto(!ddscabierto);

    return (
        <ul className={props.abierto ? 'dropdown' : 'hidden'}>
            <li className="pb-0.5"><Link to="/">Inicio</Link></li>
            <li className="flex justify-start items-center pb-1" onClick={toggle}>
                <span className="mr-2">Categorías</span>
                <FaChevronDown className={ddscabierto ? 'hidden' : ''} />
                <FaChevronUp className={!ddscabierto ? 'hidden' : ''} />
            </li>
            <li className="pb-1"><DropdownSubcat abierto={ddscabierto} /></li>
            <li className="pb-2"><Link to="/contactenos">Contáctenos</Link></li>
            <li><Search /></li>
        </ul>
    )
}

export default Dropdown;

Dropdown.propTypes = { abierto: PropTypes.bool.isRequired };
