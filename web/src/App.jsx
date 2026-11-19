import React from 'react';
// import Footer from "./components/Footer";
import Header from "./components/Header";
import SubCatLista from "./pages/SubCatLista";
import ProductosXSubCat from "./pages/ProductosXSubCat";
import ProductosXDesc from "./pages/ProductosXDesc";
import Contacto from "./pages/Contacto";
import NotFound from "./pages/NotFound";
import { Route, Routes } from 'react-router-dom'
import { WhatsAppButton } from './components/WhatsAppButton';

function App() {

    return (
        <>
            <Header />
            <div className="w-11/12 mx-auto bg-gris-claro pb-48 lg:pb-32 h-screen">
                <Routes>
                    <Route exact path="/" element={<SubCatLista />} />
                    <Route exact path="/categorias/:subcat" element={<ProductosXSubCat />} />
                    <Route exact path="/productos/buscar/:descripcion" element={<ProductosXDesc />} />
                    <Route exact path="/contactenos" element={<Contacto />} />
                    <Route path="/*" element={<NotFound />} />
                </Routes>
            </div>
            {/* <Footer /> */}
            <WhatsAppButton />
        </>
    )
}

export default App
