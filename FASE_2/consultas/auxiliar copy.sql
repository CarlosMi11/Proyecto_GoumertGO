select cp.idCliente
from ClientePedido as cp
GROUP BY cp.idCliente
HAVING COUNT(cp.idPedido) > 1