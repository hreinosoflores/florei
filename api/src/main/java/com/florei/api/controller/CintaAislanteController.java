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

import com.florei.api.model.CintaAislante;
import com.florei.api.repo.CintaAislanteRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/cintaaislante")
@CrossOrigin
public class CintaAislanteController {
	@Autowired
	private CintaAislanteRepository cintaAislanteRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, cintaAislanteRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody CintaAislante cintaAislante) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			cintaAislante.getAuditoria().setActivo(true);
			cintaAislante.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, cintaAislanteRepository.save(cintaAislante));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody CintaAislante cintaAislante) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			cintaAislante.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, cintaAislanteRepository.save(cintaAislante));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			cintaAislanteRepository.deleteById(id);
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
			CintaAislante cintaAislante = cintaAislanteRepository.findById(id).orElse(null);
			if (cintaAislante != null) {
				cintaAislante.getAuditoria().setActivo(!cintaAislante.getAuditoria().getActivo());
				cintaAislante.getAuditoria().setFechaModificacion(new Date());
				cintaAislante.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, cintaAislanteRepository.save(cintaAislante));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
