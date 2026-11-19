import React from 'react';
import axios from 'axios';
import PropTypes from "prop-types";


function LuzTbody(props) {

    const [luz, setLuz] = React.useState({
        "potencia": null,
        "flujoLuminoso": null,
        "duracion": null
    });

    React.useEffect(() => {

        async function fetchData() {
            try {
                const response = await axios({
                    method: 'GET',
                    url: `${import.meta.env.VITE_URL_API}luz`
                });

                setLuz(response.data.resultado
                    .find(luz =>
                        luz.auditoria.activo &&
                        luz.producto.id === props.idProd
                    )
                );

            } catch (error) {
                console.error(error);
            }
        }

        fetchData();

    }, [props.idProd]);


    return (
        <tbody>
            <tr>
                <td className="producto-td">Potencia</td>
                <td className="producto-td">{
                    luz.potencia == null || luz.potencia === 0 ?
                        import.meta.env.VITE_SINDATOS :
                        luz.potencia === 1 ?
                            "1 Watt" :
                            `${luz.potencia} Watts`

                }</td>
            </tr>
            <tr>
                <td className="producto-td">Flujo Luminoso</td>
                <td className="producto-td">{
                    luz.flujoLuminoso == null || luz.flujoLuminoso === 0 ?
                        import.meta.env.VITE_SINDATOS :
                        `${luz.flujoLuminoso} Lm`
                }</td>
            </tr>
            <tr>
                <td className="producto-td">Duración</td>
                <td className="producto-td">{
                    luz.duracion == null || luz.duracion === 0 ?
                        import.meta.env.VITE_SINDATOS :
                        `${luz.duracion} Hrs.`
                }</td>
            </tr>

        </tbody>
    )
}

export default LuzTbody;

LuzTbody.propTypes = { idProd: PropTypes.number.isRequired };
