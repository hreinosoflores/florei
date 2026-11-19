package com.florei.api.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.florei.api.model.Factura;
import com.florei.api.repo.FacturaRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/factura")
@CrossOrigin
public class FacturaController {

	@Autowired
	private FacturaRepository facturaRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, facturaRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody Factura factura) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			factura.getAuditoria().setActivo(true);
			factura.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, facturaRepository.save(factura));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody Factura factura) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			factura.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, facturaRepository.save(factura));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			facturaRepository.deleteById(id);
			Global.resultOK(result, id);
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PatchMapping("/activo/{usu}/{id}")
	public Map<String, Object> toggleActivo(@PathVariable Long usu, @PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Factura factura = facturaRepository.findById(id).orElse(null);
			if (factura != null) {
				factura.getAuditoria().setActivo(!factura.getAuditoria().getActivo());
				factura.getAuditoria().setFechaModificacion(new Date());
				factura.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, facturaRepository.save(factura));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
