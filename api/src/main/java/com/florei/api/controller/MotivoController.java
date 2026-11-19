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

import com.florei.api.model.Motivo;
import com.florei.api.repo.MotivoRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/motivo")
@CrossOrigin
public class MotivoController {

	@Autowired
	private MotivoRepository motivoRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, motivoRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody Motivo motivo) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			motivo.getAuditoria().setActivo(true);
			motivo.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, motivoRepository.save(motivo));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody Motivo motivo) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			motivo.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, motivoRepository.save(motivo));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			motivoRepository.deleteById(id);
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
			Motivo motivo = motivoRepository.findById(id).orElse(null);
			if (motivo != null) {
				motivo.getAuditoria().setActivo(!motivo.getAuditoria().getActivo());
				motivo.getAuditoria().setFechaModificacion(new Date());
				motivo.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, motivoRepository.save(motivo));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
