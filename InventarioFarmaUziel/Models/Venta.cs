using System;
using System.Collections.Generic;

namespace InventarioFarmaUziel.Models;

public partial class Venta
{
    public int IdVenta { get; set; }

    public int IdCliente { get; set; }

    public int IdMedicamento { get; set; }

    public int Cantidadv { get; set; }

    public DateTime FechaVenta { get; set; }

    public double? Subtotalv { get; set; }

    public double? Totalv { get; set; }

    public virtual Cliente IdClienteNavigation { get; set; } = null!;

    public virtual Medicamento IdMedicamentoNavigation { get; set; } = null!;
}
