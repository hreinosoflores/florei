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

import com.florei.api.model.Transportista;
import com.florei.api.repo.TransportistaRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/transportista")
@CrossOrigin
public class TransportistaController {

	@Autowired
	private TransportistaRepository transportistaRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, transportistaRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody Transportista transportista) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			transportista.getAuditoria().setActivo(true);
			transportista.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, transportistaRepository.save(transportista));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody Transportista transportista) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			transportista.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, transportistaRepository.save(transportista));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			transportistaRepository.deleteById(id);
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
			Transportista transportista = transportistaRepository.findById(id).orElse(null);
			if (transportista != null) {
				transportista.getAuditoria().setActivo(!transportista.getAuditoria().getActivo());
				transportista.getAuditoria().setFechaModificacion(new Date());
				transportista.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, transportistaRepository.save(transportista));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
