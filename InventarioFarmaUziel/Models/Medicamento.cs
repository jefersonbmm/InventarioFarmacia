using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace InventarioFarmaUziel.Models;

public partial class Medicamento
{
    public int IdMedicamento { get; set; }

    public string NombreMed { get; set; } = null!;

    public DateTime FechaElab { get; set; }

    public DateTime FechaVenc { get; set; }

    public string DescProd { get; set; } = null!;

    public double Precio { get; set; }

    public int Cantidad { get; set; }

    public string Distribuidora { get; set; } = null!;

    public virtual ICollection<Venta> Venta { get; } = new List<Venta>();
}
